export default function() {
    this.lines = []
    this.totalLines = 0
    this.maxLines = 100

    this.addLine = function(line) {
        this.lines.push(line.replace(/\r?\n|\r/g, ' '))

        const toDelete = this.lines.length - this.maxLines
        if (toDelete > 0) {
            this.lines.splice(0, toDelete)
        }
        this.totalLines++

        return line
    }

    this.getFirstLineNumber = function()
    {
        return Math.max(this.totalLines - this.maxLines, 0) + 1
    }

    this.asText = function() {
        return this.lines.join("\n")
    }

    this.clear = function() {
        this.lines = []
        this.totalLines = 0
    }
}