"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.command = void 0;
const marked_1 = require("marked");
const TerminalRenderer = require("marked-terminal");
const command_1 = require("../command");
const requireAuth_1 = require("../requireAuth");
const ext_dev_upload_1 = require("./ext-dev-upload");
const utils_1 = require("../utils");
const extensionsHelper_1 = require("../extensions/extensionsHelper");
marked_1.marked.setOptions({
    renderer: new TerminalRenderer(),
});
exports.command = new command_1.Command("ext:dev:publish <extensionRef>")
    .description(`Deprecated. Use ext:dev:upload instead`)
    .option(`-s, --stage <stage>`, `release stage (supports "alpha", "beta", "rc", and "stable")`)
    .option(`--repo <repo>`, `Public GitHub repo URI that contains the extension source`)
    .option(`--ref <ref>`, `commit hash, branch, or tag to build from the repo (defaults to HEAD)`)
    .option(`--root <root>`, `root directory that contains this extension (defaults to last uploaded root or "/" if none set)`)
    .withForce()
    .help("if you have not previously uploaded a version of this extension, this will " +
    "create the extension. If you have previously uploaded a version of this extension, this version must " +
    "be greater than previous versions.")
    .before(requireAuth_1.requireAuth)
    .before(extensionsHelper_1.ensureExtensionsPublisherApiEnabled)
    .action(async (extensionRef, options) => {
    (0, utils_1.logLabeledWarning)("Extensions", "ext:dev:publish has been deprecated and will be removed in the future. Please use ext:dev:upload instead.");
    if (!options.repo && !options.ref && !options.root) {
        options.local = true;
    }
    return (0, ext_dev_upload_1.uploadExtensionAction)(extensionRef, options);
});
