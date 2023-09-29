"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.deleteRepository = exports.getRepository = exports.createRepository = exports.fetchLinkableRepositories = exports.deleteConnection = exports.getConnection = exports.createConnection = void 0;
const apiv2_1 = require("../apiv2");
const api_1 = require("../api");
const client = new apiv2_1.Client({
    urlPrefix: api_1.cloudbuildOrigin,
    auth: true,
    apiVersion: "v2",
});
async function createConnection(projectId, location, connectionId) {
    const res = await client.post(`projects/${projectId}/locations/${location}/connections`, { githubConfig: {} }, { queryParams: { connectionId } });
    return res.body;
}
exports.createConnection = createConnection;
async function getConnection(projectId, location, connectionId) {
    const name = `projects/${projectId}/locations/${location}/connections/${connectionId}`;
    const res = await client.get(name);
    return res.body;
}
exports.getConnection = getConnection;
async function deleteConnection(projectId, location, connectionId) {
    const name = `projects/${projectId}/locations/${location}/connections/${connectionId}`;
    const res = await client.delete(name);
    return res.body;
}
exports.deleteConnection = deleteConnection;
async function fetchLinkableRepositories(projectId, location, connectionId) {
    const name = `projects/${projectId}/locations/${location}/connections/${connectionId}:fetchLinkableRepositories`;
    const res = await client.get(name);
    return res.body;
}
exports.fetchLinkableRepositories = fetchLinkableRepositories;
async function createRepository(projectId, location, connectionId, repositoryId, remoteUri) {
    const res = await client.post(`projects/${projectId}/locations/${location}/connections/${connectionId}/repositories`, { remoteUri }, { queryParams: { repositoryId } });
    return res.body;
}
exports.createRepository = createRepository;
async function getRepository(projectId, location, connectionId, repositoryId) {
    const name = `projects/${projectId}/locations/${location}/connections/${connectionId}/repositories/${repositoryId}`;
    const res = await client.get(name);
    return res.body;
}
exports.getRepository = getRepository;
async function deleteRepository(projectId, location, connectionId, repositoryId) {
    const name = `projects/${projectId}/locations/${location}/connections/${connectionId}/repositories/${repositoryId}`;
    const res = await client.delete(name);
    return res.body;
}
exports.deleteRepository = deleteRepository;
