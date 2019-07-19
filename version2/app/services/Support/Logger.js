import { EventEmitter } from 'events'

export function newLogger() {
    return new Logger;
}

class Logger extends EventEmitter {
    constructor() {
        super();
        this.lines = [];
        this.totalLines = 0;
        this.maxLines = 100;
    }

    destroy() {
        this.removeAllListeners(['log', 'progress']);
    }

    logFunc() {
        return message => this.log(message);
    }

    log(message) {
        console.log(message);
        this.addLine(message);
        this.emit('log', message);
    }

    progress(stepIndex) {
        this.emit('progress', stepIndex);
    }

    addLine(line) {
        this.lines.push(line.replace(/\r?\n|\r/g, ' '));

        const toDelete = this.lines.length - this.maxLines;
        if (toDelete > 0) {
            this.lines.splice(0, toDelete);
        }
        this.totalLines++;

        return line;
    }

    getFirstLineNumber() {
        return Math.max(this.totalLines - this.maxLines, 0) + 1;
    }

    asText() {
        return this.lines.join("\n");
    }

    clear() {
        this.lines = [];
        this.totalLines = 0;
    }
}
