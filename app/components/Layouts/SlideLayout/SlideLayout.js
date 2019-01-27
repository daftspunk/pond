import PropTypes from 'prop-types';
import React, { Component } from 'react';
import { VBox } from '../../Elements';
import styles from './SlideLayout.scss';

export default class SlideLayout extends Component {
    static propTypes = {
        close: PropTypes.element.isRequired,
        children: PropTypes.node.isRequired
    };

    static Title = props => (
        <div className={styles.title}>
            <h4 className="title is-4 has-text-grey">{props.title}</h4>
            <p className="subtitle is-6 has-text-grey">{props.subtitle}</p>
        </div>
    );

    static Content = props => (
        <VBox.Main scrollbars>
            <div className={styles.content}>
                {props.children}
            </div>
        </VBox.Main>
    );

    static Buttons = props => (
        <div className={styles.buttons}>
            {props.children}
        </div>
    )

    render() {
        const { close, children, title } = this.props;
        return (
            <div className={styles.slideView}>
                <div className={styles.close}>
                    {close}
                </div>
                <VBox className={styles.contentArea}>
                    {children}
                </VBox>
            </div>
        );
    }
}
