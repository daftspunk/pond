import React from 'react';
import PropTypes from 'prop-types';
import classnames from 'classnames';

const Control = ({
    children,
    className,
    renderAs,
    fullwidth,
    iconLeft,
    iconRight,
    loading,
    size,
    ...props
}) => {
    const Element = renderAs;
    return (
        <Element
            {...props}
            className={classnames('control', className, {
                'is-expanded': fullwidth,
                'has-icons-left': iconLeft,
                'has-icons-right': iconRight,
                'is-loading': loading,
                [`is-${size}`]: size,
            })}
        >
            {children}
        </Element>
    );
};

Control.propTypes = {
    children: PropTypes.node,
    className: PropTypes.string,
    style: PropTypes.shape({}),
    renderAs: PropTypes.oneOfType([PropTypes.string, PropTypes.func]),
    fullwidth: PropTypes.bool,
    iconLeft: PropTypes.bool,
    iconRight: PropTypes.bool,
    loading: PropTypes.bool,
    size: PropTypes.oneOf(['small', 'medium', 'large']),
};

Control.defaultProps = {
    children: null,
    className: '',
    style: {},
    renderAs: 'div',
    fullwidth: false,
    iconLeft: false,
    iconRight: false,
    loading: false,
    size: null,
};

export default Control;
