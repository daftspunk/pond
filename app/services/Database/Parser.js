/**
 * Parse attributes from Builder into query string
 */
export default class Parser {
    constructor(builder) {
        this.builder = builder;
        this.lookup = {};
    }

    query() {
        this.filters();
        this.sorts();
        this.limit();

        return this.lookup;
    }

    hasFilters() {
        return Object.keys(this.builder.filters.filter).length > 0;
    }

    hasSorts() {
        return this.builder.sorts.length > 0;
    }

    hasLimit() {
        return this.builder.limitValue !== null;
    }

    //
    // Parsers
    //

    filters() {
        if (!this.hasFilters()) {
            return;
        }

        if (!this.lookup.selector) {
            this.lookup.selector = {};
        }

        const filters = this.builder.filters.filter;

        for (const key of Object.keys(filters)) {
            this.lookup.selector[key] = filters[key];
        }
    }

    sorts() {
        if (!this.hasSorts()) {
            return;
        }

        if (!this.lookup.selector) {
            this.lookup.selector = {};
        }

        this.lookup.sort.forEach(attr => {
            if (!this.lookup.selector[attr]) {
                this.lookup.selector[attr] = { $gte: null };
            }
        });

        this.lookup.sort = this.builder.sorts;
    }

    limit() {
        if (!this.hasLimit()) {
            return;
        }

        this.lookup.limit = this.builder.limitValue;
    }
}
