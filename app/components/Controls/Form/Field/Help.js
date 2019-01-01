import React from 'react';
import PropTypes from 'prop-types';
import classnames from 'classnames';
import * as colors from '../../../../constants/ColorConstants';

const colorMap = [null].concat(Object.keys(colors).map(key => colors[key]));

const Help = ({
    className,
    children,
    color,
    ...props
}) => {
    return (
        <p
            {...props}
            className={classnames('help', className, {
                [`is-${color}`]: color,
            })}
        >
            {children}
        </p>
    );
};

Help.propTypes = {
    className: PropTypes.string,
    style: PropTypes.shape({}),
    color: PropTypes.oneOf(colorMap),
    children: PropTypes.node,
};

Help.defaultProps = {
    children: null,
    className: '',
    style: {},
    color: null,
};

export default Help;
