import React, { PureComponent } from 'react';
import PropTypes from 'prop-types';
import classnames from 'classnames';
import * as colors from '../../../../constants/ColorConstants';

const colorMap = [null].concat(Object.keys(colors).map(key => colors[key]));

export default class Input extends PureComponent {
    static propTypes = {
        className: PropTypes.string,
        style: PropTypes.shape({}),
        type: PropTypes.oneOf(['text', 'email', 'tel', 'password', 'number', 'search']),
        size: PropTypes.oneOf(['small', 'medium', 'large']),
        color: PropTypes.oneOf(colorMap),
        readOnly: PropTypes.bool,
        isStatic: PropTypes.bool,
        isRounded: PropTypes.bool,
        disabled: PropTypes.bool,
        placeholder: PropTypes.string,
        value: PropTypes.string,
        name: PropTypes.string,
    };

    static defaultProps = {
        className: '',
        value: '',
        style: {},
        type: 'text',
        size: null,
        color: null,
        readOnly: false,
        isStatic: false,
        isRounded: false,
        disabled: false,
        placeholder: '',
        name: null,
    };

    focus() {
        this.refs.input.focus();
    }

    render() {
        const {
            className,
            type,
            size,
            color,
            readOnly,
            autoFocus,
            isStatic,
            isRounded,
            disabled,
            placeholder,
            value,
            name,
            ...props
        } = this.props;

        return (
            <input
                {...props}
                ref="input"
                name={name}
                value={value}
                type={type}
                placeholder={placeholder}
                readOnly={readOnly || isStatic}
                disabled={disabled}
                autoFocus={autoFocus}
                className={classnames('input', className, {
                    'is-static': isStatic,
                    'is-rounded': isRounded,
                    [`is-${size}`]: size,
                    [`is-${color}`]: color,
                })}
            />
        );
    }
}
