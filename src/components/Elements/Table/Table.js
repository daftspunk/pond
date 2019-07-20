import React from 'react';
import PropTypes from 'prop-types';
import classnames from 'classnames';
import styles from './Table.scss';

const Table = ({
    children,
    className,
    size,
    striped,
    hoverable,
    clickable,
    bordered,
    ...props
}) => {
    return (
        <table
            {...props}
            className={classnames('table', className, {
                [`is-${size}`]: size,
                'is-bordered': bordered,
                'is-striped': striped,
                'is-hoverable': hoverable,
                'is-clickable': clickable,
            })}
        >
            {children}
        </table>
    );
};

Table.propTypes = {
    children: PropTypes.node,
    className: PropTypes.string,
    style: PropTypes.shape({}),
    size: PropTypes.oneOf(['fullwidth', 'narrow']),
    striped: PropTypes.bool,
    hoverable: PropTypes.bool,
    clickable: PropTypes.bool,
    bordered: PropTypes.bool,
};

Table.defaultProps = {
    children: null,
    className: '',
    style: {},
    size: 'fullwidth',
    striped: false,
    hoverable: false,
    clickable: false,
    bordered: false,
};

export default Table;
