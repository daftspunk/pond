import React from 'react'
import PropTypes from 'prop-types'
import classnames from 'classnames'

const Checkbox = ({
    className,
    style,
    disabled,
    checkedValue,
    children,
    value,
    name,
    ...props
}) => (
    <label
        htmlFor={name}
        disabled={disabled}
        className={classnames('checkbox', className)}
        style={style}
    >
        <input
            {...props}
            name={name}
            type="checkbox"
            value={checkedValue ? '1' :'0'}
            disabled={disabled}
            checked={value}
        />
        {children}
    </label>
)

Checkbox.propTypes = {
    children: PropTypes.node,
    className: PropTypes.string,
    style: PropTypes.shape({}),
    disabled: PropTypes.bool,
    checkedValue: PropTypes.string,
    value: PropTypes.oneOfType([
        PropTypes.string,
        PropTypes.number,
    ]),
    name: PropTypes.string,
}

Checkbox.defaultProps = {
    children: null,
    className: '',
    checkedValue: '1',
    style: {},
    disabled: false,
    value: false,
    name: null,
}

export default Checkbox
