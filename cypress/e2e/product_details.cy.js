
describe('Product Details', () => {
  beforeEach(() => {
    cy.visit('/');
  });

  it('should navigate to the product detail page when a product is clicked', () => {
    // Find the first product on the page and click it
    cy.get('article').first().within(() => {
      cy.get('a').first().click();
    });

    // Assert that the product detail page is loaded
    cy.url().should('include', '/products/');
    cy.get('article.product-detail').should('exist');
  });
});