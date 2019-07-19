import React from 'react';
import PropTypes from 'prop-types';
import classnames from 'classnames';

const LevelItem = ({
    children,
    className,
    renderAs,
    narrow,
    centered,
    ...props
}) => {
    const Element = renderAs;
    return (
        <Element
            {...props}
            className={classnames('level-item', className, {
                'is-narrow': narrow,
                'has-text-centered': centered
            })}>
            {children}
        </Element>
    );
};

LevelItem.propTypes = {
    children: PropTypes.node,
    className: PropTypes.string,
    centered: PropTypes.bool,
    /**
     * `true` to remove space between columns
     */
    narrow: PropTypes.bool,
    style: PropTypes.shape({}),
    renderAs: PropTypes.oneOfType([PropTypes.string, PropTypes.func]),
};

LevelItem.defaultProps = {
    centered: false,
    narrow: false,
    children: null,
    className: '',
    style: {},
    renderAs: 'div',
};

export default LevelItem;
