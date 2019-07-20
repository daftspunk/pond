import Application from '@packages/Foundation/Application';

export default function app(abstract) {
    if (!abstract) {
        return Application.getInstance();
    }

    Application.getInstance().get(abstract);
}
