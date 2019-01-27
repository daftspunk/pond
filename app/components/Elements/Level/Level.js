import React from 'react';
import PropTypes from 'prop-types';
import classnames from 'classnames';
import LevelSide from './Level.Side';
import LevelItem from './Level.Item';
import styles from './Level.scss';

//
// Usage
//

/*
<Level>
    <Level.Side align="left">
        <Level.Item>
            ...
        </Level.Item>
    </Level.Side>
    <Level.Side align="right">
        ...
    </Level.Side>
</Level>
*/

const CONSTANT_BREAKPOINTS = {
    DESKTOP: 'desktop',
    TABLET: 'tablet',
    MOBILE: 'mobile',
    WIDESCREEN: 'widescreen',
    FULLHD: 'fullhd',
}

const breakpoints = [null].concat(Object.keys(CONSTANT_BREAKPOINTS).map(key => CONSTANT_BREAKPOINTS[key]));

const Level = ({
    children,
    className,
    breakpoint,
    renderAs,
    ...props
}) => {
    const Element = renderAs;
    return (
        <Element
            {...props}
            className={classnames('level', className, {
                [`is-${breakpoint}`]: breakpoint,
            })}
        >
            {children}
        </Element>
    );
};

Level.Side = LevelSide;

Level.Item = LevelItem;

Level.propTypes = {
    children: PropTypes.node,
    className: PropTypes.string,
    style: PropTypes.shape({}),
    breakpoint: PropTypes.oneOf(breakpoints),
    renderAs: PropTypes.oneOfType([PropTypes.string, PropTypes.func]),
};

Level.defaultProps = {
    children: null,
    className: '',
    style: {},
    breakpoint: null,
    renderAs: 'div',
};

export default Level;
