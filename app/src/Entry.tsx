import * as React from 'react';
import * as ReactDOM from 'react-dom';
import App from './App';

class Entry {

    private readonly element: HTMLElement;
    private observer: MutationObserver | undefined = undefined;

    private readonly observerConfig: MutationObserverInit = {
        attributeFilter: [],
        attributeOldValue: false,
        attributes: true,
        characterData: false,
        characterDataOldValue: false,
        childList: false,
        subtree: false,
    };

    public constructor(elementId: string) {
        const element: HTMLElement | null = document.getElementById(elementId);

        if (element === null) {
            throw new Error(`Element id "${elementId}" not found`);
        }

        this.element = element;
        this.observer = undefined;
    }

    public observe(callback: () => void): void {
        this.observer = new MutationObserver(callback);
        this.observer.observe(this.element, this.observerConfig);
    }

    public render(): void {
        ReactDOM.render(
            <App />,
            this.element
        );
    }
}

((): void => {
    const entry: Entry = new Entry('app');
    entry.render();

    entry.observe(() => {
        entry.render();
    });
})();
