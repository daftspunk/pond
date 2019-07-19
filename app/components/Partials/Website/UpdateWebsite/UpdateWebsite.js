import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import { Modal } from '../../../Controls';
import { Button } from '../../../Elements';
import WebsiteForm from './UpdateWebsite.Form';
import { WebsiteActions } from '../../../../actions/WebsiteActions';

class UpdateWebsite extends Component {
    static propTypes = {
        item: PropTypes.object,
    };

    static defaultProps = {
    }

    onClose = () => {
        if (this.props.item.onClose) {
            this.props.item.onClose()
        }

        this.props.onClose(this.props.item)
    }

    render() {
        const { onClose, editWebsite } = this.props;

        return (
            <React.Fragment>
                <Modal showClose={false} onClose={onClose}>
                    <WebsiteForm
                        {...this.props}
                        initialValues={editWebsite}
                        onClose={this.onClose} />
                </Modal>
            </React.Fragment>
        )
    }
}

export default connect(
    state => ({
        editWebsite: state.website.editWebsite,
    }),
    dispatch => bindActionCreators({
        ...WebsiteActions
    }, dispatch)
)(UpdateWebsite)
