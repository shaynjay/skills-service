/*
 * Copyright 2020 SkillTree
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
describe('Skills Table Tests', () => {
    const tableSelector = '[data-cy="skillsTable"]'

    beforeEach(() => {
        cy.request('POST', '/app/projects/proj1', {
            projectId: 'proj1',
            name: 'proj1'
        });
        cy.request('POST', '/admin/projects/proj1/subjects/subj1', {
            projectId: 'proj1',
            subjectId: 'subj1',
            name: 'Subject 1'
        });
    });

    it('create first skill then remove it', () => {
        cy.visit('/projects/proj1/subjects/subj1');
        cy.contains('No Skills Yet');

        const skillName = 'This is a Skill'
        cy.get('[data-cy="btn_Skills"').click();
        cy.get('[data-cy="skillName"]').type(skillName)
        cy.clickSave();

        cy.validateTable(tableSelector, [
            [{ colIndex: 0,  value: skillName }, { colIndex: 2,  value: 1 }],
        ], 10);

        cy.get('[data-cy="deleteSkillButton_ThisisaSkillSkill"]').click();
        cy.contains('YES, Delete It!').click();
        cy.contains('No Skills Yet');
    });

    it('edit existing skill', () => {

        cy.intercept('POST', '/admin/projects/proj1/subjects/subj1/skills/skill2').as('saveSkill');

        const numSkills = 3;
        for (let skillsCounter = 1; skillsCounter <= numSkills; skillsCounter += 1) {
            cy.request('POST', `/admin/projects/proj1/subjects/subj1/skills/skill${skillsCounter}`, {
                projectId: 'proj1',
                subjectId: 'subj1',
                skillId: `skill${skillsCounter}`,
                name: `Very Great Skill # ${skillsCounter}`,
                pointIncrement: '150',
                numPerformToCompletion: skillsCounter < 3 ? '1' : '200',
            });
        };

        cy.visit('/projects/proj1/subjects/subj1');

        // force the order
        cy.contains('Display Order').click();

        cy.validateTable(tableSelector, [
            [{ colIndex: 0,  value: 'Very Great Skill # 1' }, { colIndex: 1,  value: 1 }],
            [{ colIndex: 0,  value: 'Very Great Skill # 2' }, { colIndex: 1,  value: 2 }],
            [{ colIndex: 0,  value: 'Very Great Skill # 3' }, { colIndex: 1,  value: 3 }],
        ], 10);

        cy.get('[data-cy="editSkillButton_skill2"]').click();
        const otherSkillName = 'Other Skill';
        cy.get('[data-cy="skillName"]').clear().type(otherSkillName);
        cy.clickSave();
        cy.wait('@saveSkill');

        cy.validateTable(tableSelector, [
            [{ colIndex: 0,  value: 'Very Great Skill # 1' }, { colIndex: 1,  value: 1 }],
            [{ colIndex: 0,  value: otherSkillName }, { colIndex: 1,  value: 2 }],
            [{ colIndex: 0,  value: 'Very Great Skill # 3' }, { colIndex: 1,  value: 3 }],
        ], 10);
    });

    it('sort by skill and order', () => {

        const numSkills = 13;
        const expected = [];
        for (let skillsCounter = 1; skillsCounter <= numSkills; skillsCounter += 1) {
            const skillName = `Skill # ${skillsCounter}`;
            expected.push([{ colIndex: 0,  value: skillName }, { colIndex: 1,  value: skillsCounter }])
            cy.request('POST', `/admin/projects/proj1/subjects/subj1/skills/skill${skillsCounter}`, {
                projectId: 'proj1',
                subjectId: 'subj1',
                skillId: `skill${skillsCounter}`,
                name: skillName,
                pointIncrement: '150',
                numPerformToCompletion: skillsCounter < 3 ? '1' : '200',
            });
        };

        cy.visit('/projects/proj1/subjects/subj1');

        // test skill name sorting
        cy.get(`${tableSelector} th`).contains('Skill').click();
        cy.validateTable(tableSelector, expected, 10);

        cy.get(`${tableSelector} th`).contains('Skill').click();
        cy.validateTable(tableSelector, expected.map((item) => item).reverse(), 10);

        cy.get(`${tableSelector} th`).contains('Display Order').click();
        cy.validateTable(tableSelector, expected, 10);


        cy.get(`${tableSelector} th`).contains('Display Order').click();
        cy.validateTable(tableSelector, expected.map((item) => item).reverse(), 10);
    });

    it('sort by created date', () => {

        const numSkills = 3;
        const expected = [];
        for (let skillsCounter = 1; skillsCounter <= numSkills; skillsCounter += 1) {
            const skillName = `Skill # ${skillsCounter}`;
            expected.push([{ colIndex: 0,  value: skillName }, { colIndex: 1,  value: skillsCounter }])
            cy.request('POST', `/admin/projects/proj1/subjects/subj1/skills/skill${skillsCounter}`, {
                projectId: 'proj1',
                subjectId: 'subj1',
                skillId: `skill${skillsCounter}`,
                name: skillName,
                pointIncrement: '150',
                numPerformToCompletion: skillsCounter,
            });
            cy.wait(1001);
        };

        cy.visit('/projects/proj1/subjects/subj1');

        // test created column
        cy.get(`${tableSelector} th`).contains('Created').click();
        cy.validateTable(tableSelector, expected, 10);

        cy.get(`${tableSelector} th`).contains('Created').click();
        cy.validateTable(tableSelector, expected.map((item) => item).reverse(), 10);
    });

    it('sort by additional fields', () => {

        const numSkills = 3;
        const expected = [];
        for (let skillsCounter = 1; skillsCounter <= numSkills; skillsCounter += 1) {
            const skillName = `Skill # ${skillsCounter}`;
            expected.push([{ colIndex: 0,  value: skillName }, { colIndex: 1,  value: skillsCounter }])
            cy.request('POST', `/admin/projects/proj1/subjects/subj1/skills/skill${skillsCounter}`, {
                projectId: 'proj1',
                subjectId: 'subj1',
                skillId: `skill${skillsCounter}`,
                name: skillName,
                pointIncrement: '150',
                numPerformToCompletion: skillsCounter,
                version: skillsCounter,
            });
        };

        cy.visit('/projects/proj1/subjects/subj1');

        // test points column
        cy.get('[data-cy="skillsTable-additionalColumns"]').contains('Points').click();
        cy.get(`${tableSelector} th`).contains('Points').click();
        cy.validateTable(tableSelector, [
            [{ colIndex: 0,  value: 'Skill # 1' }, { colIndex: 3,  value: 150 }],
            [{ colIndex: 0,  value: 'Skill # 2' }, { colIndex: 3,  value: 300 }],
            [{ colIndex: 0,  value: 'Skill # 3' }, { colIndex: 3,  value: 450 }],
        ], 10);

        // test points column
        cy.get(`${tableSelector} th`).contains('Points').click();
        cy.validateTable(tableSelector, [
            [{ colIndex: 0,  value: 'Skill # 3' }, { colIndex: 3,  value: 450 }],
            [{ colIndex: 0,  value: 'Skill # 2' }, { colIndex: 3,  value: 300 }],
            [{ colIndex: 0,  value: 'Skill # 1' }, { colIndex: 3,  value: 150 }],
        ], 10);

        // test version column
        cy.get('[data-cy="skillsTable-additionalColumns"]').contains('Version').click();
        cy.get(`${tableSelector} th`).contains('Version').click();
        cy.validateTable(tableSelector, [
            [{ colIndex: 0,  value: 'Skill # 1' }, { colIndex: 4,  value: 1 }],
            [{ colIndex: 0,  value: 'Skill # 2' }, { colIndex: 4,  value: 2 }],
            [{ colIndex: 0,  value: 'Skill # 3' }, { colIndex: 4,  value: 3 }],
        ], 10);

        cy.get(`${tableSelector} th`).contains('Version').click();
        cy.validateTable(tableSelector, [
            [{ colIndex: 0,  value: 'Skill # 3' }, { colIndex: 4,  value: 3 }],
            [{ colIndex: 0,  value: 'Skill # 2' }, { colIndex: 4,  value: 2 }],
            [{ colIndex: 0,  value: 'Skill # 1' }, { colIndex: 4,  value: 1 }],
        ], 10);
    });

    it('Time Window field formatting', () => {

        const numSkills = 4;
        const expected = [];
        for (let skillsCounter = 0; skillsCounter <= numSkills; skillsCounter += 1) {
            const skillName = `Skill # ${skillsCounter}`;
            expected.push([{ colIndex: 0,  value: skillName }, { colIndex: 1,  value: skillsCounter }])
            cy.request('POST', `/admin/projects/proj1/subjects/subj1/skills/skill${skillsCounter}`, {
                projectId: 'proj1',
                subjectId: 'subj1',
                skillId: `skill${skillsCounter}`,
                name: skillName,
                pointIncrement: '150',
                pointIncrementInterval: 30 * (skillsCounter),
                numPerformToCompletion: skillsCounter <= 1 ? 1 : skillsCounter,
                version: skillsCounter + 1,
            });
        };

        cy.visit('/projects/proj1/subjects/subj1');

        // test points column
        cy.get('[data-cy="skillsTable-additionalColumns"]').contains('Time Window').click();
        cy.get(`${tableSelector} th`).contains('Display Order').click();
        cy.validateTable(tableSelector, [
            [{ colIndex: 0,  value: 'Skill # 0' }, { colIndex: 3,  value: 'Time Window Disabled' }],
            [{ colIndex: 0,  value: 'Skill # 1' }, { colIndex: 3,  value: 'Time Window N/A' }],
            [{ colIndex: 0,  value: 'Skill # 2' }, { colIndex: 3,  value: '1 Hour' }],
            [{ colIndex: 0,  value: 'Skill # 3' }, { colIndex: 3,  value: '1 Hour 30 Minutes' }],
            [{ colIndex: 0,  value: 'Skill # 4' }, { colIndex: 3,  value: '2 Hours' }],
        ], 10);
      });

    it('change display order', () => {

        const numSkills = 4;
        for (let skillsCounter = 1; skillsCounter <= numSkills; skillsCounter += 1) {
            const skillName = `Skill # ${skillsCounter}`;
            cy.request('POST', `/admin/projects/proj1/subjects/subj1/skills/skill${skillsCounter}`, {
                projectId: 'proj1',
                subjectId: 'subj1',
                skillId: `skill${skillsCounter}`,
                name: skillName,
                pointIncrement: '150',
                numPerformToCompletion: skillsCounter,
                version: skillsCounter,
            });
        };

        cy.visit('/projects/proj1/subjects/subj1');

        // sort is enabled when sorted by display order column
        cy.get('[data-cy="orderMoveUp_skill1"]').should('be.disabled');
        cy.get('[data-cy="orderMoveUp_skill2"]').should('be.disabled');
        cy.get('[data-cy="orderMoveUp_skill3"]').should('be.disabled');
        cy.get('[data-cy="orderMoveUp_skill4"]').should('be.disabled');
        cy.get('[data-cy="orderMoveDown_skill1"]').should('be.disabled');
        cy.get('[data-cy="orderMoveDown_skill2"]').should('be.disabled');
        cy.get('[data-cy="orderMoveDown_skill3"]').should('be.disabled');
        cy.get('[data-cy="orderMoveDown_skill4"]').should('be.disabled');

        cy.get(`${tableSelector} th`).contains('Display Order').click();
        cy.get('[data-cy="orderMoveUp_skill1"]').should('be.disabled');
        cy.get('[data-cy="orderMoveUp_skill2"]').should('be.enabled');
        cy.get('[data-cy="orderMoveUp_skill3"]').should('be.enabled');
        cy.get('[data-cy="orderMoveUp_skill4"]').should('be.enabled');
        cy.get('[data-cy="orderMoveDown_skill1"]').should('be.enabled');
        cy.get('[data-cy="orderMoveDown_skill2"]').should('be.enabled');
        cy.get('[data-cy="orderMoveDown_skill3"]').should('be.enabled');
        cy.get('[data-cy="orderMoveDown_skill4"]').should('be.disabled');

    })

});
