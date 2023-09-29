"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getBuildConfig = exports.getServerConfig = exports.getBrowserConfig = exports.getContext = exports.getAllTargets = void 0;
const utils_1 = require("../utils");
const error_1 = require("../../error");
const path_1 = require("path");
async function localesForTarget(dir, architectHost, target, workspaceProject) {
    var _a;
    const { targetStringFromTarget } = (0, utils_1.relativeRequire)(dir, "@angular-devkit/architect");
    const targetOptions = await architectHost.getOptionsForTarget(target);
    if (!targetOptions)
        throw new error_1.FirebaseError(`Couldn't find options for ${targetStringFromTarget(target)}.`);
    let locales = undefined;
    let defaultLocale = undefined;
    if (targetOptions.localize) {
        const i18n = (_a = workspaceProject.extensions) === null || _a === void 0 ? void 0 : _a.i18n;
        if (!i18n)
            throw new error_1.FirebaseError(`No i18n config on project.`);
        if (typeof i18n.sourceLocale === "string") {
            throw new error_1.FirebaseError(`All your i18n locales must have a baseHref of "" on Firebase, use an object for sourceLocale in your angular.json:
  "i18n": {
    "sourceLocale": {
      "code": "${i18n.sourceLocale}",
      "baseHref": ""
    },
    ...
  }`);
        }
        if (i18n.sourceLocale.baseHref !== "")
            throw new error_1.FirebaseError('All your i18n locales must have a baseHref of "" on Firebase, errored on sourceLocale.');
        defaultLocale = i18n.sourceLocale.code;
        if (targetOptions.localize === true) {
            locales = [defaultLocale];
            for (const [locale, { baseHref }] of Object.entries(i18n.locales)) {
                if (baseHref !== "")
                    throw new error_1.FirebaseError(`All your i18n locales must have a baseHref of \"\" on Firebase, errored on ${locale}.`);
                locales.push(locale);
            }
        }
        else if (Array.isArray(targetOptions.localize)) {
            locales = [defaultLocale];
            for (const locale of targetOptions.localize) {
                if (typeof locale !== "string")
                    continue;
                locales.push(locale);
            }
        }
    }
    (0, utils_1.validateLocales)(locales);
    return { locales, defaultLocale };
}
const DEV_SERVER_TARGETS = [
    "@angular-devkit/build-angular:dev-server",
    "@nguniversal/builders:ssr-dev-server",
];
function getValidBuilders(purpose) {
    return [
        "@angular/fire:deploy",
        "@angular-devkit/build-angular:browser",
        "@nguniversal/builders:prerender",
        ...(purpose === "deploy" ? [] : DEV_SERVER_TARGETS),
    ];
}
async function getAllTargets(purpose, dir) {
    const validBuilders = getValidBuilders(purpose);
    const { NodeJsAsyncHost } = (0, utils_1.relativeRequire)(dir, "@angular-devkit/core/node");
    const { workspaces } = (0, utils_1.relativeRequire)(dir, "@angular-devkit/core");
    const { targetStringFromTarget } = (0, utils_1.relativeRequire)(dir, "@angular-devkit/architect");
    const host = workspaces.createWorkspaceHost(new NodeJsAsyncHost());
    const { workspace } = await workspaces.readWorkspace(dir, host);
    const targets = [];
    workspace.projects.forEach((projectDefinition, project) => {
        if (projectDefinition.extensions.projectType !== "application")
            return;
        projectDefinition.targets.forEach((targetDefinition, target) => {
            if (!validBuilders.includes(targetDefinition.builder))
                return;
            const configurations = Object.keys(targetDefinition.configurations || {});
            if (!configurations.includes("production"))
                configurations.push("production");
            if (!configurations.includes("development"))
                configurations.push("development");
            configurations.forEach((configuration) => {
                targets.push(targetStringFromTarget({ project, target, configuration }));
            });
        });
    });
    return targets;
}
exports.getAllTargets = getAllTargets;
async function getContext(dir, targetOrConfiguration) {
    const { NodeJsAsyncHost } = (0, utils_1.relativeRequire)(dir, "@angular-devkit/core/node");
    const { workspaces } = (0, utils_1.relativeRequire)(dir, "@angular-devkit/core");
    const { WorkspaceNodeModulesArchitectHost } = (0, utils_1.relativeRequire)(dir, "@angular-devkit/architect/node");
    const { Architect, targetFromTargetString, targetStringFromTarget } = (0, utils_1.relativeRequire)(dir, "@angular-devkit/architect");
    const { parse } = (0, utils_1.relativeRequire)(dir, "jsonc-parser");
    const host = workspaces.createWorkspaceHost(new NodeJsAsyncHost());
    const { workspace } = await workspaces.readWorkspace(dir, host);
    const architectHost = new WorkspaceNodeModulesArchitectHost(workspace, dir);
    const architect = new Architect(architectHost);
    let overrideTarget;
    let project;
    let browserTarget;
    let serverTarget;
    let prerenderTarget;
    let serveTarget;
    let serveOptimizedImages = false;
    let deployTargetName;
    let configuration = undefined;
    if (targetOrConfiguration) {
        try {
            overrideTarget = targetFromTargetString(targetOrConfiguration);
            configuration = overrideTarget.configuration;
            project = overrideTarget.project;
        }
        catch (e) {
            deployTargetName = "deploy";
            configuration = targetOrConfiguration;
        }
    }
    if (!project) {
        const angularJson = parse(await host.readFile((0, path_1.join)(dir, "angular.json")));
        project = angularJson.defaultProject;
    }
    if (!project) {
        const apps = [];
        workspace.projects.forEach((value, key) => {
            if (value.extensions.projectType === "application")
                apps.push(key);
        });
        if (apps.length === 1)
            project = apps[0];
    }
    if (!project)
        throw new error_1.FirebaseError("Unable to determine the application to deploy, specify a target via the FIREBASE_FRAMEWORKS_BUILD_TARGET environment variable");
    const workspaceProject = workspace.projects.get(project);
    if (!workspaceProject)
        throw new error_1.FirebaseError(`No project ${project} found.`);
    if (overrideTarget) {
        const target = workspaceProject.targets.get(overrideTarget.target);
        const builder = target.builder;
        if (builder === "@angular/fire:deploy")
            deployTargetName = overrideTarget.target;
        if (builder === "@angular-devkit/build-angular:browser")
            browserTarget = overrideTarget;
        if (builder === "@nguniversal/builders:prerender")
            prerenderTarget = overrideTarget;
        if (typeof builder === "string" && DEV_SERVER_TARGETS.includes(builder))
            serveTarget = overrideTarget;
    }
    const deployTargetDefinition = deployTargetName
        ? workspaceProject.targets.get(deployTargetName)
        : undefined;
    if ((deployTargetDefinition === null || deployTargetDefinition === void 0 ? void 0 : deployTargetDefinition.builder) === "@angular/fire:deploy") {
        const options = deployTargetDefinition.options;
        if (typeof (options === null || options === void 0 ? void 0 : options.prerenderTarget) === "string")
            prerenderTarget = targetFromTargetString(options.prerenderTarget);
        if (typeof (options === null || options === void 0 ? void 0 : options.browserTarget) === "string")
            browserTarget = targetFromTargetString(options.browserTarget);
        if (typeof (options === null || options === void 0 ? void 0 : options.serverTarget) === "string")
            serverTarget = targetFromTargetString(options.serverTarget);
        if (options === null || options === void 0 ? void 0 : options.serveOptimizedImages) {
            serveOptimizedImages = true;
        }
        if (!browserTarget)
            throw new Error("ng-deploy is missing a browser target. Plase check your angular.json.");
        if (prerenderTarget) {
            const prerenderOptions = await architectHost.getOptionsForTarget(prerenderTarget);
            if (targetStringFromTarget(browserTarget) !== (prerenderOptions === null || prerenderOptions === void 0 ? void 0 : prerenderOptions.browserTarget))
                throw new Error("ng-deploy's browserTarget and prerender's browserTarget do not match. Please check your angular.json");
            if (serverTarget && targetStringFromTarget(serverTarget) !== (prerenderOptions === null || prerenderOptions === void 0 ? void 0 : prerenderOptions.serverTarget))
                throw new Error("ng-deploy's serverTarget and prerender's serverTarget do not match. Please check your angular.json");
            if (!serverTarget)
                console.warn("Treating the application as fully rendered. Add a serverTarget to your deploy target in angular.json to utilize server-side rendering.");
        }
    }
    if (!overrideTarget && !prerenderTarget && workspaceProject.targets.has("prerender")) {
        const { defaultConfiguration = "production" } = workspaceProject.targets.get("prerender");
        prerenderTarget = { project, target: "prerender", configuration: defaultConfiguration };
    }
    if (serveTarget) {
        const options = await architectHost.getOptionsForTarget(serveTarget);
        if (typeof (options === null || options === void 0 ? void 0 : options.browserTarget) !== "string")
            throw new Error(`${serveTarget.target} browserTarget expected to be string, check your angular.json.`);
        browserTarget = targetFromTargetString(options.browserTarget);
        if (options === null || options === void 0 ? void 0 : options.serverTarget) {
            if (typeof options.serverTarget !== "string")
                throw new Error(`${serveTarget.target} serverTarget expected to be string, check your angular.json.`);
            serverTarget = targetFromTargetString(options.serverTarget);
        }
    }
    else if (prerenderTarget) {
        const options = await architectHost.getOptionsForTarget(prerenderTarget);
        if (typeof (options === null || options === void 0 ? void 0 : options.browserTarget) !== "string")
            throw new Error("Prerender browserTarget expected to be string, check your angular.json.");
        browserTarget = targetFromTargetString(options.browserTarget);
        if (typeof (options === null || options === void 0 ? void 0 : options.serverTarget) !== "string")
            throw new Error("Prerender serverTarget expected to be string, check your angular.json.");
        serverTarget = targetFromTargetString(options.serverTarget);
    }
    if (!browserTarget && workspaceProject.targets.has("build")) {
        const { defaultConfiguration = "production" } = workspaceProject.targets.get("build");
        browserTarget = { project, target: "build", configuration: defaultConfiguration };
    }
    if (!serverTarget && workspaceProject.targets.has("server")) {
        const { defaultConfiguration = "production" } = workspaceProject.targets.get("server");
        serverTarget = { project, target: "server", configuration: defaultConfiguration };
    }
    if (!serveTarget) {
        if (serverTarget && workspaceProject.targets.has("serve-ssr")) {
            const { defaultConfiguration = "development" } = workspaceProject.targets.get("serve-ssr");
            serveTarget = { project, target: "serve-ssr", configuration: defaultConfiguration };
        }
        else if (workspaceProject.targets.has("serve")) {
            const { defaultConfiguration = "development" } = workspaceProject.targets.get("serve");
            serveTarget = { project, target: "serve", configuration: defaultConfiguration };
        }
    }
    if (configuration) {
        if (prerenderTarget)
            prerenderTarget.configuration = configuration;
        if (serverTarget)
            serverTarget.configuration = configuration;
        if (browserTarget)
            browserTarget.configuration = configuration;
        if (serveTarget)
            serveTarget.configuration = configuration;
    }
    if (!browserTarget)
        throw new error_1.FirebaseError(`No browser target on ${project}`);
    const browserTargetOptions = await architectHost.getOptionsForTarget(browserTarget);
    if (!browserTargetOptions) {
        throw new error_1.FirebaseError(`Couldn't find options for ${targetStringFromTarget(browserTarget)}.`);
    }
    const baseHref = browserTargetOptions.baseHref || "/";
    if (typeof baseHref !== "string") {
        throw new error_1.FirebaseError(`baseHref on ${targetStringFromTarget(browserTarget)} was not a string`);
    }
    return {
        architect,
        architectHost,
        baseHref,
        host,
        browserTarget,
        prerenderTarget,
        serverTarget,
        serveTarget,
        workspaceProject,
        serveOptimizedImages,
    };
}
exports.getContext = getContext;
async function getBrowserConfig(sourceDir, configuration) {
    const { architectHost, browserTarget, baseHref, workspaceProject } = await getContext(sourceDir, configuration);
    const { locales, defaultLocale } = await localesForTarget(sourceDir, architectHost, browserTarget, workspaceProject);
    const browserTargetOptions = await architectHost.getOptionsForTarget(browserTarget);
    if (typeof (browserTargetOptions === null || browserTargetOptions === void 0 ? void 0 : browserTargetOptions.outputPath) !== "string")
        throw new Error("browserTarget output path is not a string");
    const outputPath = browserTargetOptions.outputPath;
    return { locales, baseHref, outputPath, defaultLocale };
}
exports.getBrowserConfig = getBrowserConfig;
async function getServerConfig(sourceDir, configuration) {
    var _a;
    const { architectHost, host, serverTarget, browserTarget, baseHref, workspaceProject, serveOptimizedImages, } = await getContext(sourceDir, configuration);
    const browserTargetOptions = await architectHost.getOptionsForTarget(browserTarget);
    if (typeof (browserTargetOptions === null || browserTargetOptions === void 0 ? void 0 : browserTargetOptions.outputPath) !== "string")
        throw new Error("browserTarget output path is not a string");
    const browserOutputPath = browserTargetOptions.outputPath;
    const packageJson = JSON.parse(await host.readFile((0, path_1.join)(sourceDir, "package.json")));
    if (!serverTarget) {
        return {
            packageJson,
            browserOutputPath,
            serverOutputPath: undefined,
            baseHref,
            bundleDependencies: false,
            externalDependencies: [],
            serverLocales: [],
            browserLocales: undefined,
            defaultLocale: undefined,
            serveOptimizedImages,
        };
    }
    const { locales: serverLocales, defaultLocale } = await localesForTarget(sourceDir, architectHost, serverTarget, workspaceProject);
    const serverTargetOptions = await architectHost.getOptionsForTarget(serverTarget);
    if (typeof (serverTargetOptions === null || serverTargetOptions === void 0 ? void 0 : serverTargetOptions.outputPath) !== "string")
        throw new Error("serverTarget output path is not a string");
    const serverOutputPath = serverTargetOptions.outputPath;
    if (serverLocales && !defaultLocale) {
        throw new error_1.FirebaseError("It's required that your source locale to be one of the localize options");
    }
    const externalDependencies = serverTargetOptions.externalDependencies || [];
    const bundleDependencies = (_a = serverTargetOptions.bundleDependencies) !== null && _a !== void 0 ? _a : true;
    const { locales: browserLocales } = await localesForTarget(sourceDir, architectHost, browserTarget, workspaceProject);
    return {
        packageJson,
        browserOutputPath,
        serverOutputPath,
        baseHref,
        bundleDependencies,
        externalDependencies,
        serverLocales,
        browserLocales,
        defaultLocale,
        serveOptimizedImages,
    };
}
exports.getServerConfig = getServerConfig;
async function getBuildConfig(sourceDir, configuration) {
    const { targetStringFromTarget } = (0, utils_1.relativeRequire)(sourceDir, "@angular-devkit/architect");
    const { browserTarget, baseHref, prerenderTarget, serverTarget, architectHost, workspaceProject, serveOptimizedImages, } = await getContext(sourceDir, configuration);
    const targets = (prerenderTarget ? [prerenderTarget] : [browserTarget, serverTarget].filter((it) => !!it)).map((it) => targetStringFromTarget(it));
    const locales = await localesForTarget(sourceDir, architectHost, browserTarget, workspaceProject);
    return {
        targets,
        baseHref,
        serverTarget,
        locales,
        serveOptimizedImages,
    };
}
exports.getBuildConfig = getBuildConfig;
