import { CodePart } from './code-part';

export class Code {
    public codeParts: CodePart[] = [
        new CodePart('idle', '', 'Ant has nothing to do', []),
        new CodePart('seeSugar', '', 'Ant discovers Sugar', ['sugar']),
        new CodePart('seeApple', '', 'Ant discovers Apple', ['apple']),
        new CodePart('arriveAtSugar', '', 'Ant arrives at Sugar', ['sugar']),
        new CodePart('arriveAtApple', '', 'Ant arrives Apple', ['apple']),

        new CodePart('seeAnt', '', 'Ant sees hostile Ant ', ['ant']),
        new CodePart('seeBug', '', 'Ant sees hostile Bug', ['bug']),
        new CodePart('hasDied', '', 'Ant sees Sugar', ['sugar']),
        new CodePart('arriveAtAnt', '', 'Ant arrives at other Ant', ['ant']),
        new CodePart('arriveAtBug', '', 'Ant arrives at Bug', ['bug']),
    ];

    constructor() {
    }

    public toModuleString(): string {
        let methods: string = '';
        this.codeParts.forEach((codePart) => {
            methods +=
                `${codePart.methodName}: function(${codePart.parameters}) {
                ${codePart.code} 
            },
            `;
        });

        methods = methods.slice(0, -1);

        const moduleString: string = `
        let ant = { 
            ${methods} 
        }
                    
        module.exports = ant;
        `;

        return moduleString;
    }
}

