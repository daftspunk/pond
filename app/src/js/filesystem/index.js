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

module.exports = {
    copy
}