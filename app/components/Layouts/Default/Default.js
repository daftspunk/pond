import React, { Component } from 'react'
import PropTypes from 'prop-types'
import GlobalModals from '../../Partials/Site/GlobalModals/GlobalModals'
import GlobalSlides from '../../Partials/Site/GlobalSlides/GlobalSlides'
import styles from './Default.scss'

export default class Default extends Component {
    static propTypes = {
        sidebar: PropTypes.element.isRequired,
        children: PropTypes.node.isRequired,
    };

    render() {
        const { sidebar, children } = this.props;
        return (
            <React.Fragment>
                <div className={styles.sidebarContainer}>
                    {sidebar}
                </div>
                <div className={styles.mainContainer}>
                    {children}
                </div>
                <GlobalModals />
                <GlobalSlides />
            </React.Fragment>
        );
    }
}
