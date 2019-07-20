import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import { Scrollbars } from 'react-custom-scrollbars';
import classnames from 'classnames';
import { ProjectActions } from '@modules/system/actions/ProjectActions';
import { WebsiteActions } from '@modules/system/actions/WebsiteActions';
import { Button, Icon } from '../../../Elements';
import styles from '../../../Layouts/Default/Default.scss';
import OctoberIcon from '../../../Elements/Icon/Icons/OctoberIcon';

class SidebarNav extends Component {
    static propTypes = {
        onFetchWebsites: PropTypes.func.isRequired,
        onSetActiveProject: PropTypes.func.isRequired,
        onSetNewProject: PropTypes.func.isRequired,
        project: PropTypes.shape({}),
        projects: PropTypes.arrayOf(PropTypes.shape({})),
    };

    static defaultProps = {
        project: {},
        projects: [],
    };

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

    setActiveProject(project) {
        const { onFetchWebsites, onSetActiveProject } = this.props;

        onFetchWebsites(project.id);
        onSetActiveProject(project);
    }

    render() {
        const { NavItem, AddItem } = SidebarNav;
        const { projects, project, onSetNewProject } = this.props;

        return (
            <div>
                <div className={styles.sidebar}>
                    {/*
                    <div className={styles.sidebarSettings}>
                        <NavItem icon="cog" />
                    </div>
                    */}
                    <div className={styles.sidebarTools}>
                        <Scrollbars>
                            {projects.map(p => (
                                <NavItem
                                    key={p.name}
                                    icon={p.icon||'leaf'}
                                    onClick={()=>this.setActiveProject(p)}
                                    active={project.id===p.id}>{p.name}</NavItem>
                            ))}
                            <AddItem onClick={onSetNewProject} />
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
    dispatch => bindActionCreators({
        ...WebsiteActions,
        ...ProjectActions
    }, dispatch)
)(SidebarNav)
