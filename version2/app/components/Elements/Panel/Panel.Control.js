import React from 'react';
import PropTypes from 'prop-types';
import classnames from 'classnames';

const PanelControl = ({
    className,
    renderAs,
    ...props
}) => {
    const Element = renderAs;
    return (
        <Element
            {...props}
            className={classnames('control', className)}
        />
    );
};

PanelControl.propTypes = {
    className: PropTypes.string,
    renderAs: PropTypes.oneOfType([
        PropTypes.string,
        PropTypes.func,
    ]),
};

PanelControl.defaultProps = {
    className: '',
    renderAs: 'div',
};

export default PanelControl;
