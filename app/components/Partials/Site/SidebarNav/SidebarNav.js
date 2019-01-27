import React, { Component } from 'react'
import { bindActionCreators } from 'redux'
import { connect } from 'react-redux'
import { Button, Icon } from '../../../Elements'
import { Scrollbars } from 'react-custom-scrollbars'
import * as routes from '../../../../constants/RouteConstants'
import styles from '../../../Layouts/Default/Default.scss'
import OctoberIcon from '../../../Elements/Icon/Icons/OctoberIcon'

import { ProjectActions } from '../../../../actions/ProjectActions'

class SidebarNav extends Component {

    static NavItem = props => (
        <Button title={props.children} size="large" rounded>
            <Icon icon={props.icon} />
        </Button>
    );

    static AddItem = props => (
        <Button title="New Site" size="large" className={styles.newNavItem} rounded {...props}>
            <Icon icon="plus" />
        </Button>
    );

    render() {
        const Item = SidebarNav.NavItem;
        const AddItem = SidebarNav.AddItem;

        return (
            <div>
                <div className={styles.sidebar}>
                    <div className={styles.sidebarSettings}>
                        <Item icon="cog">Settings</Item>
                    </div>
                    <div className={styles.sidebarTools}>
                        <Scrollbars>
                            <Item icon="briefcase">The Pond</Item>
                            <Item icon="leaf">Pet Projects</Item>
                            <AddItem onClick={this.props.onCreateProjectModal} />
                        </Scrollbars>
                    </div>
                    <div className={styles.sidebarBrand}>
                        <OctoberIcon />
                    </div>
                </div>
            </div>
        );
    }
}

export default connect(
    state => {
        return {}
    },
    dispatch => {
        return bindActionCreators({
            ...ProjectActions
        }, dispatch)
    }
)(SidebarNav)
