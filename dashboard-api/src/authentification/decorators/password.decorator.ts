import {
  registerDecorator,
  ValidationArguments,
  ValidationOptions,
  ValidatorConstraint,
  ValidatorConstraintInterface,
} from 'class-validator';

export function PasswordMatching(
  property: string,
  validationOptions?: ValidationOptions,
) {
  return (object: any, propertyName: string) => {
    registerDecorator({
      target: object.constructor,
      propertyName,
      options: validationOptions,
      constraints: [property],
      validator: PasswordMatchingConstraint,
    });
  };
}

@ValidatorConstraint({ name: 'PasswordMatching' })
export class PasswordMatchingConstraint
  implements ValidatorConstraintInterface
{
  validate(value: string, args: ValidationArguments) {
    const relatedValue: string = (args.object as any)[args.constraints[0]];
    return value === relatedValue;
  }
}
