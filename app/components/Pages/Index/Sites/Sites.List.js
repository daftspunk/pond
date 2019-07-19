import React, { Component } from 'react'
import { Link } from 'react-router-dom'
import { Panel, Button, Level, Icon } from '../../../Elements'
import { CREATE_WEBSITE } from '../../../../constants/SlideConstants'

export default class SitesList extends Component {
    render() {
        const { websites, editWebsite, onSetEditWebsite, onSetNewWebsite } = this.props;

        return (
            <Panel>
                {websites.length && websites.map(w => {
                    const icon = w.canInstall()
                        ? 'fa fa-certificate'
                        : (w.canServe() ? 'fa fa-globe' : 'fa fa-question-circle');

                    return (
                        <Panel.Block
                            renderAs="a"
                            key={w.id}
                            onClick={() => onSetEditWebsite(w)}
                            active={w.id==editWebsite.id}>
                            <Panel.Icon renderAs={Icon} icon={icon} />
                            {w.name}
                        </Panel.Block>
                    )}
                )}
                <Panel.Block renderAs="a" onClick={onSetNewWebsite}>
                    <Panel.Icon renderAs={Icon} icon="fa fa-plus" />
                    Create new website
                </Panel.Block>
            </Panel>
        );
    }
}
