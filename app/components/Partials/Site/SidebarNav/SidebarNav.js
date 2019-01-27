import React, { Component } from 'react'
import { bindActionCreators } from 'redux'
import { connect } from 'react-redux'
import { Button, Icon } from '../../../Elements'
import { Scrollbars } from 'react-custom-scrollbars'
import * as routes from '../../../../constants/RouteConstants'
import styles from '../../../Layouts/Default/Default.scss'
import OctoberIcon from '../../../Elements/Icon/Icons/OctoberIcon'
import classnames from 'classnames'

import { ProjectActions } from '../../../../actions/ProjectActions'

class SidebarNav extends Component {

    static NavItem = ({ active, ...props }) => (
        <Button
            title={props.children}
            className={classnames({[styles.navItemActive]: active })}
            size="large" rounded
            {...props}>
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
        const { projects, project, onSetActiveProject } = this.props;

        return (
            <div>
                <div className={styles.sidebar}>
                    <div className={styles.sidebarSettings}>
                        <Item icon="cog">Settings</Item>
                    </div>
                    <div className={styles.sidebarTools}>
                        <Scrollbars>
                            {projects.map((p, i) => (
                                <Item
                                    key={i}
                                    icon={p.icon||'leaf'}
                                    onClick={()=>onSetActiveProject(p)}
                                    active={project.id==p.id}>{p.name}</Item>
                            ))}
                            <AddItem onClick={this.props.onSetNewProject} />
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
    state => ({
        projects: state.project.projects,
        project: state.project.project || {}
    }),
    dispatch => {
        return bindActionCreators({
            ...ProjectActions
        }, dispatch)
    }
)(SidebarNav)
