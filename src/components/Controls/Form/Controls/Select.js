import React, { PureComponent } from 'react';
import PropTypes from 'prop-types';
import classnames from 'classnames';
import * as colors from '@constants/ColorConstants';

const colorMap = [null].concat(Object.keys(colors).map(key => colors[key]))

export default class Select extends PureComponent {

    static propTypes = {
        children: PropTypes.node,
        className: PropTypes.string,
        style: PropTypes.shape({}),
        size: PropTypes.oneOf(['small', 'medium', 'large']),
        color: PropTypes.oneOf(colorMap),
        readOnly: PropTypes.bool,
        disabled: PropTypes.bool,
        multiple: PropTypes.bool,
        fullwidth: PropTypes.bool,
        loading: PropTypes.bool,
        value: PropTypes.oneOfType([
            PropTypes.string,
            PropTypes.number,
        ]),
        name: PropTypes.string,
        options: PropTypes.arrayOf(PropTypes.shape([])),
    }

    static defaultProps = {
        children: null,
        className: '',
        value: '',
        style: {},
        size: null,
        color: null,
        readOnly: false,
        disabled: false,
        multiple: false,
        fullwidth: true,
        loading: false,
        name: null,
        options: null,
    }

    renderOptions = (options) => options.map((option, index) => <option key={index} value={option[0]}>{option[1]}</option>)

    render() {
        const {
            className,
            style,
            size,
            color,
            loading,
            readOnly,
            disabled,
            value,
            multiple,
            fullwidth,
            children,
            name,
            options,
            ...props
        } = this.props

        const selectChildren = options ? this.renderOptions(options) : children

        return (
            <div
                className={classnames('select', className, {
                    [`is-${size}`]: size,
                    [`is-${color}`]: color,
                    'is-loading': loading,
                    'is-multiple': multiple,
                    'is-fullwidth': fullwidth,
                })}
                style={style}
            >
                <select
                    {...props}
                    multiple={multiple}
                    defaultValue={value}
                    readOnly={readOnly}
                    disabled={disabled}
                    name={name}
                >
                    {selectChildren}
                </select>
            </div>
        )
    }
}
