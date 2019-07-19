import Parser from './Parser';

/**
 * Prepare attributes to be parsed
 */
export default class Builder {
    constructor(model) {
        this.model = model;
        this.sorts = [];
        this.limitValue = null;

        this.filters = {
            filter: {}
        }

        this.parser = new Parser(this);
    }

    // query string parsed 
    query() {
        return this.parser.query();
    }

    where(key, value) {
        if (key === undefined || value === undefined) {
            throw new Error('The KEY and VALUE are required on where() method.');
        }

        if (Array.isArray(value) || value instanceof Object) {
            throw new Error('The VALUE must be primitive on where() method.');
        }

        this.filters.filter[key] = value;

        return this;
    }

    whereIn(key, array) {
        if (!Array.isArray(array)) {
            throw new Error('The second argument on whereIn() method must be an array.');
        }

        this.filters.filter[key] = array.join(',');

        return this;
    }

    orderBy(...args) {
        this.sorts = args;

        return this;
    }

    limit(value) {
        if (!Number.isInteger(value)) {
            throw new Error('The VALUE must be an integer on limit() method.');
        }

        this.limitValue = value;

        return this;
    }
}
