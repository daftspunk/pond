import React, { Component } from 'react'
import { bindActionCreators } from 'redux'
import { connect } from 'react-redux'
import { Button, Level } from '../../../Elements'
import { WebsiteActions } from '../../../../actions/WebsiteActions'
import { SlideActions } from '../../../../actions/SlideActions'
import SlideLayout from '../../../Layouts/SlideLayout/SlideLayout'
import WebsiteForm from './CreateWebsite.Form';

class CreateWebsite extends Component {
    render() {
        const { onCloseSlides } = this.props;

        return (
            <SlideLayout close={<Button remove size="medium" onClick={onCloseSlides} />}>
                <WebsiteForm {...this.props} />
            </SlideLayout>
        )
    }
}

export default connect(
    state => ({
        // showSelect: state.project.showSelect,
        // showForm: state.project.showForm,
    }),
    dispatch => bindActionCreators({
        ...SlideActions,
        ...WebsiteActions
    }, dispatch)
)(CreateWebsite)
