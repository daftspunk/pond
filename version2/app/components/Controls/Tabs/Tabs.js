import React from 'react';
import PropTypes from 'prop-types';
import classnames from 'classnames';
import Tab from './Tab/Tab';
import styles from './Tabs.scss';

const Tabs = ({
    children,
    className,
    renderAs,
    align,
    size,
    type,
    fullwidth,
    ...props
}) => {
    const Element = renderAs;
    return (
        <Element
            {...props}
            className={classnames('tabs', className, {
                [`is-${align}`]: align,
                [`is-${size}`]: size,
                'is-toggle': type === 'toggle-rounded',
                [`is-${type}`]: type,
                'is-fullwidth': fullwidth,
            })}
        >
            <ul>
                {children}
            </ul>
        </Element>
    );
};

Tabs.Tab = Tab;

Tabs.propTypes = {
    children: PropTypes.node,
    className: PropTypes.string,
    style: PropTypes.shape({}),
    renderAs: PropTypes.oneOfType([
        PropTypes.string,
        PropTypes.func,
    ]),
    align: PropTypes.oneOf(['centered', 'right']),
    size: PropTypes.oneOf(['small', 'medium', 'large']),
    type: PropTypes.oneOf(['toggle', 'boxed', 'toggle-rounded']),
    fullwidth: PropTypes.bool,
};

Tabs.defaultProps = {
    children: null,
    className: '',
    style: {},
    renderAs: 'div',
    align: null,
    size: null,
    type: null,
    fullwidth: false,
};

export default Tabs;
