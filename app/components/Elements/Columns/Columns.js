import React from 'react';
import PropTypes from 'prop-types';
import classNames from 'classnames';
import Column from './Items/Column';
import COLUMN_CONSTANTS from './ColumnConstants';
import styles from './Columns.scss';

const CONSTANT_BREAKPOINTS = {
    DESKTOP: 'desktop',
    TABLET: 'tablet',
    MOBILE: 'mobile',
    WIDESCREEN: 'widescreen',
    FULLHD: 'fullhd',
}

const breakpoints = [null].concat(Object.keys(CONSTANT_BREAKPOINTS).map(key => CONSTANT_BREAKPOINTS[key]));

const Columns = ({
    children,
    className,
    breakpoint,
    gapless,
    multiline,
    centered,
    fullheight,
    ...props
}) => {
    return (
        <div
            {...props}
            className={classNames(className, 'columns', {
                [`is-${breakpoint}`]: breakpoint,
                'is-gapless': gapless,
                'is-multiline': multiline,
                'is-centered': centered,
                'is-fullheight': fullheight,
            })}
        >
            {children}
        </div>
    );
};

Columns.Column = Column;

Columns.CONSTANTS = COLUMN_CONSTANTS;

Columns.propTypes = {
    children: PropTypes.node,
    className: PropTypes.string,
    style: PropTypes.shape({}),
    /**
     * Breakpoint where columns become stacked.
     */
    breakpoint: PropTypes.oneOf(breakpoints),
    /**
     * `true` to remove space between columns
     */
    gapless: PropTypes.bool,
    /**
     * `true` if you want to use more than one line if you add more column elements that would fit in a single row.
     */
    multiline: PropTypes.bool,
    /**
     * `true` you want the columns inside to be horizontaly centered
     */
    centered: PropTypes.bool,
    /**
     * `true` you want the columns to stretch to full height
     */
    fullheight: PropTypes.bool,
};

Columns.defaultProps = {
    children: null,
    className: '',
    style: {},
    breakpoint: null,
    gapless: false,
    centered: false,
    fullheight: false,
    multiline: true,
};

export default Columns;
