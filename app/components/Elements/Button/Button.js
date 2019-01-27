import React from 'react';
import PropTypes from 'prop-types';
import classnames from 'classnames';
import styles from './Button.scss';
import * as colors from '../../../constants/ColorConstants';

const colorMap = [null, ''].concat(Object.keys(colors).map(key => colors[key]));

const Button = ({
    children,
    className,
    renderAs,
    color,
    size,
    outlined,
    inverted,
    state,
    submit,
    reset,
    fullwidth,
    loading,
    disabled,
    remove,
    isBlock,
    isStatic,
    rounded,
    onClick,
    text,
    ...props
}) => {
    let Element = isStatic ? 'span' : renderAs;
    const otherProps = {
        type: 'button'
    };
    if (submit) {
        Element = 'button';
        otherProps.type = 'submit';
    }
    if (reset) {
        Element = 'button';
        otherProps.type = 'reset';
    }

    return (
        <Element
            tabIndex={disabled ? -1 : 0}
            {...props}
            {...otherProps}
            disabled={disabled}
            onClick={disabled ? undefined : onClick}
            className={classnames(className, {
                [`is-${color}`]: color,
                [`is-${size}`]: size,
                [`is-${state}`]: state,
                'is-block': isBlock,
                'is-static': isStatic,
                'is-rounded': rounded,
                'is-outlined': outlined,
                'is-inverted': inverted,
                'is-fullwidth': fullwidth,
                'is-loading': loading,
                'is-text': text,
                delete: remove,
                button: !remove,
            })}
        >
            {children}
        </Element>
    );
};

Button.propTypes = {
    children: PropTypes.node,
    className: PropTypes.string,
    style: PropTypes.shape({}),
    renderAs: PropTypes.oneOfType([
        PropTypes.oneOf(['a', 'button']),
        PropTypes.func,
    ]),
    onClick: PropTypes.func,
    color: PropTypes.oneOf(colorMap),
    size: PropTypes.oneOf(['small', 'medium', 'large']),
    state: PropTypes.oneOf(['hover', 'focus', 'active', 'loading']),
    outlined: PropTypes.bool,
    inverted: PropTypes.bool,
    submit: PropTypes.bool,
    reset: PropTypes.bool,
    loading: PropTypes.bool,
    fullwidth: PropTypes.bool,
    disabled: PropTypes.bool,
    remove: PropTypes.bool,
    isBlock: PropTypes.bool,
    isStatic: PropTypes.bool,
    rounded: PropTypes.bool,
    text: PropTypes.bool,
};

Button.defaultProps = {
    children: null,
    className: '',
    style: {},
    renderAs: 'button',
    onClick: () => null,
    color: null,
    size: null,
    state: null,
    outlined: false,
    inverted: false,
    submit: false,
    reset: false,
    fullwidth: false,
    loading: false,
    disabled: false,
    remove: false,
    isBlock: false,
    isStatic: false,
    rounded: false,
    text: false,
};

export default Button;

