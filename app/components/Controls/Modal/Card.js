import React from 'react';
import PropTypes from 'prop-types';
import classnames from 'classnames';

import ModalCardHead from './Card/Head';
import ModalCardBody from './Card/Body';
import ModalCardFoot from './Card/Foot';
import ModalCardTitle from './Card/Title';

const ModalCard = ({
    className,
    onClose,
    children,
    ...props
}) => {
    return (
        <div
            {...props}
            className={classnames('modal-card', className)}
        >
            {children}
        </div>
    );
};


ModalCard.Head = ModalCardHead;

ModalCard.Body = ModalCardBody;

ModalCard.Foot = ModalCardFoot;

ModalCard.Title = ModalCardTitle;

ModalCard.propTypes = {
    children: PropTypes.node,
    className: PropTypes.string,
    style: PropTypes.shape({}),
    onClose: PropTypes.func,
};

ModalCard.defaultProps = {
    children: null,
    className: '',
    style: {},
    onClose: null,
};

export default ModalCard;
