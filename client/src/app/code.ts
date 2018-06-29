import { CodePart } from './code-part';

export class Code {
    public codeParts: CodePart[] = [
        new CodePart('idle', '', 'Ant has nothing to do', ['ant', 'position']),
        new CodePart('seeSugar', '', 'Ant sees Sugar', [])
    ];

    constructor() {
    }

    public toModuleString(): string {
        let methods: string = '';
        this.codeParts.forEach((codePart) => {
            methods +=
                `${codePart.methodName}: function(${codePart.parameters}) {
                ${codePart.code} 
            },`;
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

