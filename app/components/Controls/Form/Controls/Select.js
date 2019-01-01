import React from 'react';
import PropTypes from 'prop-types';
import classnames from 'classnames';
import * as colors from '../../../../constants/ColorConstants';

const colorMap = [null].concat(Object.keys(colors).map(key => colors[key]));

const Select = ({
    className,
    style,
    size,
    color,
    loading,
    readOnly,
    disabled,
    value,
    multiple,
    children,
    name,
    ...props
}) => {
    return (
        <div
            className={classnames('select', className, {
                [`is-${size}`]: size,
                [`is-${color}`]: color,
                'is-loading': loading,
                'is-multiple': multiple,
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
                {children}
            </select>
        </div>
    );
};

Select.propTypes = {
    children: PropTypes.node,
    className: PropTypes.string,
    style: PropTypes.shape({}),
    size: PropTypes.oneOf(['small', 'medium', 'large']),
    color: PropTypes.oneOf(colorMap),
    readOnly: PropTypes.bool,
    disabled: PropTypes.bool,
    multiple: PropTypes.bool,
    loading: PropTypes.bool,
    value: PropTypes.oneOfType([
        PropTypes.string,
        PropTypes.number,
    ]),
    /**
     * The name of the input field Commonly used for [multi-input handling](https://reactjs.org/docs/forms.html#handling-multiple-inputs)
     */
    name: PropTypes.string,
};

Select.defaultProps = {
    children: null,
    className: '',
    value: '',
    style: {},
    size: null,
    color: null,
    readOnly: false,
    disabled: false,
    multiple: false,
    loading: false,
    name: null,
};

export default Select;
