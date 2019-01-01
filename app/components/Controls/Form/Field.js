import React from 'react';
import PropTypes from 'prop-types';
import classnames from 'classnames';
import { Control, Label, Help } from './Form';

const Field = ({
    label,
    comment,
    className,
    renderAs,
    align,
    multiline,
    horizontal,
    kind,
    ...props
}) => {
    const Element = renderAs;
    let k = null;

    if (kind === 'addons') {
        k = 'has-addons';
    }
    else if (kind === 'group') {
        k = 'is-grouped';
    }

    let elementClass = classnames('field', className, {
        [`${k}`]: k,
        [`${k}-${align}`]: k && align,
        [`${k}-multiline`]: k === 'is-grouped' && multiline,
        'is-horizontal': horizontal,
    });

    if (label) {
        return (
            <Element {...props} className={elementClass}>
                <Label>{label}</Label>
                <Control>{props.children}</Control>
                { comment ? <Help>{comment}</Help> : '' }
            </Element>
        );
    }
    else {
        return <Element {...props} className={elementClass} />;
    }
};

Field.propTypes = {
    children: PropTypes.node,
    className: PropTypes.string,
    style: PropTypes.shape({}),
    renderAs: PropTypes.oneOfType([PropTypes.string, PropTypes.func]),
    align: PropTypes.oneOf(['centered', 'right']),
    kind: PropTypes.oneOf(['addons', 'group']),
    multiline: PropTypes.bool,
    horizontal: PropTypes.bool,
};

Field.defaultProps = {
    label: null,
    comment: null,
    children: null,
    className: '',
    style: {},
    renderAs: 'div',
    align: null,
    kind: null,
    multiline: false,
    horizontal: false,
};

export default Field;
