import React, { Component } from 'react'
import { bindActionCreators } from 'redux'
import { connect } from 'react-redux'
import { Button, Level } from '../../../Elements'
import { WebsiteActions } from '../../../../actions/WebsiteActions'
import { SlideActions } from '../../../../actions/SlideActions'
import SlideLayout from '../../../Layouts/Slide/Slide'
import WebsiteForm from './CreateWebsite.Form'
import WebsiteProgress from './CreateWebsite.Progress'

class CreateWebsite extends Component {
    render() {
        const { onCloseSlides, newWebsiteBuilding, initialWebsiteValues } = this.props;

        return (
            <SlideLayout close={<Button remove size="medium" onClick={onCloseSlides} />}>
                {newWebsiteBuilding ? (
                    <WebsiteProgress {...this.props} />
                ) : (
                    <WebsiteForm {...this.props} initialValues={initialWebsiteValues} />
                )}
            </SlideLayout>
        )
    }
}

export default connect(
    state => {
        const initialWebsiteValues = {
            localPort: 8080
        }

        return {
            project: state.project.project || {},
            newWebsiteBuilding: state.website.newWebsiteBuilding,
            initialWebsiteValues
        }
    },
    dispatch => bindActionCreators({
        ...SlideActions,
        ...WebsiteActions
    }, dispatch)
)(CreateWebsite)
