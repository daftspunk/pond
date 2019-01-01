import PropTypes from 'prop-types';
import React, { Component } from 'react';
import { Link } from 'react-router-dom';
import * as routes from '../../../constants/RouteConstants';
import GlobalModals from '../../Partials/Site/GlobalModals/GlobalModalsContainer';
import styles from './Default.scss';

export default class Default extends Component {
    static propTypes = {
        sidebar: PropTypes.element.isRequired,
        children: PropTypes.node.isRequired,
    };

    render() {
        return (
            <React.Fragment>
                <div className={styles.sidebarContainer}>
                    {this.props.sidebar}
                </div>
                <div className={styles.mainContainer}>
                    {this.props.children}
                </div>
                <GlobalModals />
            </React.Fragment>
        );
    }
}
