import * as React from 'react';
import {
    BrowserRouter as Router,
    Switch,
    Route,
    Link
} from 'react-router-dom';

export default class App extends React.Component {
    public render(): React.ReactElement<Router> {
        return (
            <Router>
                <nav>
                    <ul>
                        <li>
                            <Link to="/">Home</Link>
                        </li>
                        <li>
                            <Link to="/about">About</Link>
                        </li>
                    </ul>
                </nav>
                <Switch>
                    <Route path="/about">
                        <h1>This is about page, HTTP rewrite is working.</h1>
                    </Route>
                    <Route path="/">
                        <h1>This is home page, it's working.</h1>
                    </Route>
                </Switch>
            </Router>
        );
    }
}
