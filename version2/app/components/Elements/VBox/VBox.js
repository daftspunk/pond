import React from 'react'
import PropTypes from 'prop-types'
import classnames from 'classnames'
import VBoxMain from './VBox.Main'
import styles from './VBox.scss'

//
// Usage
//

/*
<VBox>
    <div>Block Element</div>
    <VBox.Main scrollbars>Content</VBox.Main>
    <div>Block Element</div>
</VBox>
*/

const VBox = ({
    children,
    className,
    renderAs,
    ...props
}) => {
    const Element = renderAs
    return (
        <Element
            {...props}
            className={classnames(styles.verticalBox, className)}
        >
            {children}
        </Element>
    )
}

VBox.Main = VBoxMain;

VBox.propTypes = {
    children: PropTypes.node,
    className: PropTypes.string,
    style: PropTypes.shape({}),
    renderAs: PropTypes.oneOfType([
        PropTypes.string,
        PropTypes.func,
    ]),
}

VBox.defaultProps = {
    children: null,
    className: '',
    style: {},
    renderAs: 'div',
}

export default VBox;
