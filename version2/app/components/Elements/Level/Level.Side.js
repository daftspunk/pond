import React from 'react';
import PropTypes from 'prop-types';
import classnames from 'classnames';

const LevelSide = ({
    children,
    className,
    renderAs,
    wrap,
    align,
    ...props
}) => {
    const Element = renderAs;
    return (
        <Element
            {...props}
            className={classnames(className, {
                [`level-${align}`]: align,
                'is-wrap': wrap,
            })}>
            {children}
        </Element>
    );
};
LevelSide.propTypes = {
    children: PropTypes.node,
    className: PropTypes.string,
    /**
     * `true` to wrap column content
     */
    wrap: PropTypes.bool,
    style: PropTypes.shape({}),
    renderAs: PropTypes.oneOfType([PropTypes.string, PropTypes.func]),
    align: PropTypes.string,
};

LevelSide.defaultProps = {
    wrap: false,
    children: null,
    className: '',
    style: {},
    renderAs: 'div',
    align: 'left',
};

export default LevelSide;
