var nwRequire = require,
    nw = {
        require: function(module) {
            return nwRequire(module)
        }
    }

global.nw = nw

module.exports = {
    'nw': nw
};