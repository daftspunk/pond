import * as React from 'react';
import Titlebar from '../components/Controls/Titlebar/Titlebar';

class App extends React.Component {
    render() {
        return (
            <React.Fragment>
                <Titlebar />
                {this.props.children}
            </React.Fragment>
        );
    }
}

export default App;