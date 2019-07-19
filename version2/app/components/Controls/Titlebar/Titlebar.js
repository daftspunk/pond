import React, { Component } from 'react';
import styles from './Titlebar.scss';

export default class Titlebar extends Component {
    render() {
        return (
            <header id="titlebar">
                <div id="drag-region">
                    <div id="window-title">
                        <span>October Pond</span>
                    </div>
                    <div id="window-controls">
                        <div className={styles.button} id="min-button">
                            <span>&#xE921;</span>
                        </div>
                        <div className={styles.button} id="max-button">
                            <span>&#xE922;</span>
                        </div>
                        <div className={styles.button} id="restore-button">
                            <span>&#xE923;</span>
                        </div>
                        <div className={styles.button} id="close-button">
                            <span>&#xE8BB;</span>
                        </div>
                    </div>
                </div>
            </header>
        );
    }
}
