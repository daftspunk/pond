import React, { Component } from 'react'
import { reduxForm } from 'redux-form'
import PropTypes from 'prop-types'
import { Button, ProgressIndicator, VBox } from '../../../Elements'
import { LogPanel } from '../../../Controls'
import SlideLayout from '../../../Layouts/Slide/Slide'
import styles from './CreateWebsite.scss'

export default class CreateWebsiteProgress extends Component {
    static propTypes = {
        onCloseSlides: PropTypes.func,
    };

    static defaultProps = {
    };

    render() {
        const { project, newWebsiteStep, newWebsiteLogText, onCloseSlides } = this.props;

        const steps = [
            'Preparation',
            'Downloading',
            'Extracting',
            'Copying Installer',
            'Clean up',
        ];

        return (
            <React.Fragment>
                <SlideLayout.Title title={project.name||'Pond'} subtitle="Provisioning" />
                <SlideLayout.PlainContent>
                    <VBox>
                        <div className={styles.progressIndicator}>
                            <h5 className="title is-5">Building your project</h5>
                            <ProgressIndicator steps={steps} currentStepIndex={newWebsiteStep} />
                        </div>
                        <VBox.Main>
                            <LogPanel toolbarControls={false} logText={newWebsiteLogText} />
                        </VBox.Main>
                    </VBox>
                </SlideLayout.PlainContent>
            </React.Fragment>
        )
    }
}
