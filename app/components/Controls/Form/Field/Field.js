import React from 'react';
import PropTypes from 'prop-types';
import classnames from 'classnames';
import { Control, Label, Help } from '../Form';

const Field = ({
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

    return <Element {...props} className={classnames('field', className, {
        [`${k}`]: k,
        [`${k}-${align}`]: k && align,
        [`${k}-multiline`]: k === 'is-grouped' && multiline,
        'is-horizontal': horizontal,
    })} />;
};

Field.propTypes = {
    children: PropTypes.node,
    style: PropTypes.shape({}),
    renderAs: PropTypes.oneOfType([PropTypes.string, PropTypes.func]),
    align: PropTypes.oneOf(['centered', 'right']),
    kind: PropTypes.oneOf(['addons', 'group']),
    multiline: PropTypes.bool,
    horizontal: PropTypes.bool,
};

Field.defaultProps = {
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
