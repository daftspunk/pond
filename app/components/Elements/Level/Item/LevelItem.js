import React from 'react';
import PropTypes from 'prop-types';
import classnames from 'classnames';

const LevelItem = ({
    children,
    className,
    renderAs,
    narrow,
    ...props
}) => {
    const Element = renderAs;
    return (
        <Element
            {...props}
            className={classnames('level-item', className, {
                'is-narrow': narrow,
            })}>
            {children}
        </Element>
    );
};

LevelItem.propTypes = {
    children: PropTypes.node,
    className: PropTypes.string,
    /**
     * `true` to remove space between columns
     */
    narrow: PropTypes.bool,
    style: PropTypes.shape({}),
    renderAs: PropTypes.oneOfType([PropTypes.string, PropTypes.func]),
};

LevelItem.defaultProps = {
    narrow: false,
    children: null,
    className: '',
    style: {},
    renderAs: 'div',
};

export default LevelItem;
