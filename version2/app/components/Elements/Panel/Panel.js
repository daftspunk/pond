import React from 'react';
import PropTypes from 'prop-types';
import classnames from 'classnames';
import PanelHeader from './Panel.Header';
import PanelBlock from './Panel.Block';
import PanelControl from './Panel.Control';
import PanelIcon from './Panel.Icon';
import styles from './Panel.scss';

const Panel = ({
    className,
    renderAs,
    ...props
}) => {
    const Element = renderAs;
    return (
        <Element
            {...props}
            className={classnames('panel', className)}
        />
    );
};

Panel.Header = PanelHeader;

Panel.Block = PanelBlock;

Panel.Control = PanelControl;

Panel.Icon = PanelIcon;

Panel.propTypes = {
    className: PropTypes.string,
    renderAs: PropTypes.oneOfType([
        PropTypes.string,
        PropTypes.func,
    ]),
};

Panel.defaultProps = {
    className: '',
    renderAs: 'nav',
};

export default Panel;
