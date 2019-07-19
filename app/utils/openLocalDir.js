import { resolve } from 'path'

export default function openLocalDir(fullPath) {
    const shell = require('electron').shell;
    shell.openItem(resolve(fullPath));
}
