import React from 'react'
import PropTypes from 'prop-types'
import classnames from 'classnames'
import styles from './VBox.scss'
import AutoSizer from '../AutoSizer/AutoSizer'
import { Scrollbars } from 'react-custom-scrollbars'

const MainBox = ({
    children,
    className,
    scrollbars,
    scrollbarProps,
    renderAs,
    ...props
}) => {
    const Element = renderAs
    return (
        <Element
            {...props}
            className={classnames(styles.mainBox, className)}
        >
            {scrollbars ? (
                <AutoSizer>
                    {({width, height}) => (
                        <Scrollbars {...scrollbarProps} style={{width, height}}>
                            {children}
                        </Scrollbars>
                    )}
                </AutoSizer>
            ) : children}
        </Element>
    )
}

MainBox.propTypes = {
    children: PropTypes.node,
    scrollbars: PropTypes.bool,
    className: PropTypes.string,
    scrollbarProps: PropTypes.shape({}),
    style: PropTypes.shape({}),
    renderAs: PropTypes.oneOfType([
        PropTypes.string,
        PropTypes.func,
    ]),
}

MainBox.defaultProps = {
    children: null,
    scrollbars: false,
    scrollbarProps: {},
    className: '',
    style: {},
    renderAs: 'div',
}

export default MainBox;
