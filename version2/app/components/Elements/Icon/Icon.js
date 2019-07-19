import React from 'react';
import PropTypes from 'prop-types';
import classnames from 'classnames';
import styles from './Icon.scss';
import * as colors from '../../../constants/ColorConstants';

const colorMap = [null].concat(Object.keys(colors).map(key => colors[key]));

const Icon = ({
    icon,
    size,
    color,
    className,
    align,
    children,
    ...props
}) => {
    return (
        <span
            {...props}
            className={classnames('icon', className, {
                [`is-${size}`]: size,
                [`is-${align}`]: align,
                [`has-text-${color}`]: color,
            })}
        >
            { children || (
            <i
                className={classnames('rbc', {
                    [`fa fa-${icon}`]: icon,
                })}
            />
            )}
        </span>
    );
};

Icon.propTypes = {
    icon: PropTypes.string,
    children: PropTypes.element,
    className: PropTypes.string,
    style: PropTypes.shape({}),
    size: PropTypes.oneOf(['small', 'medium', 'large']),
    align: PropTypes.oneOf(['left', 'right']),
    color: PropTypes.oneOf(colorMap),
};

Icon.defaultProps = {
    className: '',
    style: {},
    size: null,
    color: null,
    children: null,
    align: null,
    icon: null,
};

export default Icon;
