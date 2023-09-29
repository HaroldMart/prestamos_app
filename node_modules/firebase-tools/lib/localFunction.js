"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const uuid = require("uuid");
const request = require("request");
const encodeFirestoreValue_1 = require("./firestore/encodeFirestoreValue");
const utils = require("./utils");
class LocalFunction {
    constructor(trigger, urls, controller) {
        this.trigger = trigger;
        this.controller = controller;
        this.paramWildcardRegex = new RegExp("{[^/{}]*}", "g");
        this.url = urls[trigger.id];
    }
    substituteParams(resource, params) {
        if (!params) {
            return resource;
        }
        return resource.replace(this.paramWildcardRegex, (wildcard) => {
            const wildcardNoBraces = wildcard.slice(1, -1);
            const sub = params === null || params === void 0 ? void 0 : params[wildcardNoBraces];
            return sub || wildcardNoBraces + utils.randomInt(1, 9);
        });
    }
    constructCallableFunc(data, opts) {
        opts = opts || {};
        const headers = {};
        if (opts.instanceIdToken) {
            headers["Firebase-Instance-ID-Token"] = opts.instanceIdToken;
        }
        return request.post({
            callback: (...args) => this.requestCallBack(...args),
            baseUrl: this.url,
            uri: "",
            body: { data },
            json: true,
            headers: headers,
        });
    }
    constructAuth(auth, authType) {
        var _a, _b, _c;
        if ((auth === null || auth === void 0 ? void 0 : auth.admin) || (auth === null || auth === void 0 ? void 0 : auth.variable)) {
            return {
                admin: auth.admin || false,
                variable: auth.variable,
            };
        }
        if (authType) {
            switch (authType) {
                case "USER":
                    return {
                        admin: false,
                        variable: {
                            uid: (_a = auth === null || auth === void 0 ? void 0 : auth.uid) !== null && _a !== void 0 ? _a : "",
                            token: (_b = auth === null || auth === void 0 ? void 0 : auth.token) !== null && _b !== void 0 ? _b : {},
                        },
                    };
                case "ADMIN":
                    if ((auth === null || auth === void 0 ? void 0 : auth.uid) || (auth === null || auth === void 0 ? void 0 : auth.token)) {
                        throw new Error("authType and auth are incompatible.");
                    }
                    return { admin: true };
                case "UNAUTHENTICATED":
                    if ((auth === null || auth === void 0 ? void 0 : auth.uid) || (auth === null || auth === void 0 ? void 0 : auth.token)) {
                        throw new Error("authType and auth are incompatible.");
                    }
                    return { admin: false };
                default:
                    throw new Error("Unrecognized authType, valid values are: " + "ADMIN, USER, and UNAUTHENTICATED");
            }
        }
        if (auth) {
            return {
                admin: false,
                variable: {
                    uid: (_c = auth.uid) !== null && _c !== void 0 ? _c : "",
                    token: auth.token || {},
                },
            };
        }
        return { admin: true };
    }
    makeFirestoreValue(input) {
        if (typeof input === "undefined" ||
            input === null ||
            (typeof input === "object" && Object.keys(input).length === 0)) {
            return {};
        }
        if (typeof input !== "object") {
            throw new Error("Firestore data must be key-value pairs.");
        }
        const currentTime = new Date().toISOString();
        return {
            fields: (0, encodeFirestoreValue_1.encodeFirestoreValue)(input),
            createTime: currentTime,
            updateTime: currentTime,
        };
    }
    requestCallBack(err, response, body) {
        if (err) {
            return console.warn("\nERROR SENDING REQUEST: " + err);
        }
        const status = response ? response.statusCode + ", " : "";
        let bodyString = body;
        if (typeof bodyString === "string") {
            try {
                bodyString = JSON.stringify(JSON.parse(bodyString), null, 2);
            }
            catch (e) {
            }
        }
        else {
            bodyString = JSON.stringify(body, null, 2);
        }
        return console.log("\nRESPONSE RECEIVED FROM FUNCTION: " + status + bodyString);
    }
    isDatabaseFn(eventTrigger) {
        return utils.getFunctionsEventProvider(eventTrigger.eventType) === "Database";
    }
    isFirestoreFunc(eventTrigger) {
        return utils.getFunctionsEventProvider(eventTrigger.eventType) === "Firestore";
    }
    isPubsubFunc(eventTrigger) {
        return utils.getFunctionsEventProvider(eventTrigger.eventType) === "PubSub";
    }
    triggerEvent(data, opts) {
        var _a, _b, _c, _d;
        opts = opts || {};
        let operationType;
        let dataPayload;
        if (this.trigger.httpsTrigger) {
            this.controller.call(this.trigger, data || {}, opts);
        }
        else if (this.trigger.eventTrigger) {
            if (this.isDatabaseFn(this.trigger.eventTrigger)) {
                operationType = utils.last(this.trigger.eventTrigger.eventType.split("."));
                switch (operationType) {
                    case "create":
                    case "created":
                        dataPayload = {
                            data: null,
                            delta: data,
                        };
                        break;
                    case "delete":
                    case "deleted":
                        dataPayload = {
                            data: data,
                            delta: null,
                        };
                        break;
                    default:
                        dataPayload = {
                            data: data.before,
                            delta: data.after,
                        };
                }
                const resource = (_a = this.trigger.eventTrigger.resource) !== null && _a !== void 0 ? _a : (_b = this.trigger.eventTrigger.eventFilterPathPatterns) === null || _b === void 0 ? void 0 : _b.ref;
                opts.resource = this.substituteParams(resource, opts.params);
                opts.auth = this.constructAuth(opts.auth, opts.authType);
                this.controller.call(this.trigger, dataPayload, opts);
            }
            else if (this.isFirestoreFunc(this.trigger.eventTrigger)) {
                operationType = utils.last(this.trigger.eventTrigger.eventType.split("."));
                switch (operationType) {
                    case "create":
                    case "created":
                        dataPayload = {
                            value: this.makeFirestoreValue(data),
                            oldValue: {},
                        };
                        break;
                    case "delete":
                    case "deleted":
                        dataPayload = {
                            value: {},
                            oldValue: this.makeFirestoreValue(data),
                        };
                        break;
                    default:
                        dataPayload = {
                            value: this.makeFirestoreValue(data.after),
                            oldValue: this.makeFirestoreValue(data.before),
                        };
                }
                const resource = (_c = this.trigger.eventTrigger.resource) !== null && _c !== void 0 ? _c : (_d = this.trigger.eventTrigger.eventFilterPathPatterns) === null || _d === void 0 ? void 0 : _d.document;
                opts.resource = this.substituteParams(resource, opts.params);
                this.controller.call(this.trigger, dataPayload, opts);
            }
            else if (this.isPubsubFunc(this.trigger.eventTrigger)) {
                dataPayload = data;
                if (this.trigger.platform === "gcfv2") {
                    dataPayload = { message: Object.assign(Object.assign({}, data), { messageId: uuid.v4() }) };
                }
                this.controller.call(this.trigger, dataPayload || {}, opts);
            }
            else {
                this.controller.call(this.trigger, data || {}, opts);
            }
        }
        return "Successfully invoked function.";
    }
    makeFn() {
        var _a;
        if (this.trigger.httpsTrigger) {
            const isCallable = !!((_a = this.trigger.labels) === null || _a === void 0 ? void 0 : _a["deployment-callable"]);
            if (isCallable) {
                return (data, opt) => this.constructCallableFunc(data, opt);
            }
            else {
                return request.defaults({
                    callback: (...args) => this.requestCallBack(...args),
                    baseUrl: this.url,
                    uri: "",
                });
            }
        }
        else {
            return (data, opt) => this.triggerEvent(data, opt);
        }
    }
}
exports.default = LocalFunction;
