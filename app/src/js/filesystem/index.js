/**
 * Provides some file-system operations.
 * Unfortunately fs-extra doesn't work in the nw.js context.
 */

async function copy(source, destination) {
    const fs = nw.require('fs')

    return new Promise((resolve, reject) => {
        const writeStream = fs.createWriteStream(destination)
        const readStream = fs.createReadStream(source)

        readStream.pipe(writeStream)

        writeStream.on('close', () => {
            resolve(destination)
        })

        writeStream.on('error', err => reject(err))
        readStream.on('error', err => reject(err))
    })
}

async function unlink(path) {
    const fs = nw.require('fs')

    return new Promise((resolve, reject) => {
        fs.unlink(path, (err) => {
            if (!err) {
                resolve()
            }
            else {
                reject(err)
            }
        })
    })
}

function isDirectory(path) {
    const fs = nw.require('fs')

    try {
        const stat = fs.statSync(path)

        return (stat.isDirectory())
    } catch (err) {
        return false
    }
}

function isDirectoryEmpty(path) {
    const fs = nw.require('fs')
    const contents = fs.readdirSync(path)

    return !contents.some(fileName => {
        return fileName.charAt(0) !== '.'
    })
}

module.exports = {
    copy,
    unlink,
    isDirectory,
    isDirectoryEmpty
}