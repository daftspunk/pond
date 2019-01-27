import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { Button } from '../../Elements'
import styles from './Index.scss'
import image from '../../../images/welcome.png'
import { CREATE_WEBSITE } from '../../../constants/SlideConstants'

export default class NoSites extends Component {
    static propTypes = {
        onOpenSlides: PropTypes.func,
    };

    static defaultProps = {
    }

    render() {
        const { project, onOpenSlides } = this.props;

        return (
            <section className={`hero is-fullheight ${styles.noSitesContainer}`}>
                <div className="hero-body">
                    <div className="container has-text-centered">
                        <img src={image} className={styles.welcomeImage} />
                        <h4 className="title is-4 is-spaced">Welcome to {project.name||'Pond'}</h4>
                        <p className="subtitle is-6">
                            You don't have any websites in this project yet.
                            Create your first and enjoy October CMS!
                        </p>
                        <p>
                            <Button color="info" onClick={() => onOpenSlides(CREATE_WEBSITE)}>
                                Create your first website
                            </Button>
                        </p>
                    </div>
                </div>
            </section>
        )
    }
}
