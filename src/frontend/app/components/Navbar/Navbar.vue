<template>
  <nav id="topnav" class="defaultscroll is-sticky">
    <div class="" :class="container">

      <router-link v-if="lightLogo" class="logo" to="/">
        <div class="block sm:hidden">
          <img src="../../assets/images/logo-icon-40.png" class="h-10 inline-block dark:hidden" alt="">
          <img src="../../assets/images/logo-icon-40-white.png" class="h-10 hidden dark:inline-block" alt="">
        </div>
        <div class="sm:block hidden">
                        <span class="inline-block dark:hidden">
                            <img src="../../assets/images/logo-dark.png" class="h-[24px] l-dark" alt="">
                            <img src="../../assets/images/logo-light.png" class="h-[24px] l-light" alt="">
                        </span>
          <img src="../../assets/images/logo-white.png" class="h-[24px] hidden dark:inline-block" alt="">
        </div>
      </router-link>

      <router-link v-else class="logo" to="/">
        <div class="block sm:hidden">
          <img src="../../assets/images/logo-icon-40.png" class="h-10 inline-block dark:hidden" alt="">
          <img src="../../assets/images/logo-icon-40-white.png" class="h-10 hidden dark:inline-block" alt="">
        </div>
        <div class="sm:block hidden">
          <img src="../../assets/images/logo-dark.png" class="h-[24px] inline-block dark:hidden" alt="">
          <img src="../../assets/images/logo-white.png" class="h-[24px] hidden dark:inline-block" alt="">
        </div>
      </router-link>

      <div class="menu-extras" @click="handler">
        <div class="menu-item">
          <router-link to="#" class="navbar-toggle" id="isToggle" :class="toggle === false ? '' : 'open'">
            <div class="lines">
              <span></span>
              <span></span>
              <span></span>
            </div>
          </router-link>
        </div>
      </div>

      <ul class="buy-button list-none mb-0">
        <li class="inline-block mb-0">
          <div class="relative top-[3px]">
            <i class="uil uil-search text-lg absolute top-[3px] end-3"></i>
            <input type="text"
                   class="py-2 px-3 text-[14px] border border-gray-100 dark:border-gray-800 dark:text-slate-200  outline-none h-9 !pe-10 rounded-3xl sm:w-44 w-36 bg-white dark:bg-slate-900"
                   name="s" id="searchItem" placeholder="Search...">
          </div>
        </li>


      </ul>

      <div id="navigation" :class="toggle === false ? 'none' : 'block'">
        <ul class="navigation-menu" :class="lightNav">
          <li :class="activeMenu === '/contact' ? 'active' : ''">
            <NuxtLink to="/tasks" class="sub-menu-item">Home</NuxtLink>
          </li>
          <li :class="activeMenu === '/contact' ? 'active' : ''">
            <NuxtLink to="/account" class="sub-menu-item">Jobs</NuxtLink>
          </li>

        </ul>
      </div>
    </div>
  </nav>
</template>

<script>
import vClickOutside from 'v-click-outside';
import feather from 'feather-icons'

export default {
  directives: {
    clickOutside: vClickOutside.directive,
  },
  props: {
    lightLogo: {
      type: Boolean,
      required: true
    },
    lightNav: {
      type: String,
      required: true,
    },
    container: {
      type: String,
      required: true
    }
  },
  data() {
    return {
      toggle: false,
      activeMenu: '',
      menu: true,
      menuOpen: '',
      dropdownOpen: false,
    }
  },
  created() {

  },
  mounted() {
    this.activeMenu = window.location.pathname
    window.addEventListener('scroll', this.handleScroll);

    document.addEventListener('click', this.handleClickOutside);
    feather.replace();
    this.scrollToTop()
  },
  unmounted() {
    window.removeEventListener('scroll', this.handleScroll);
    document.removeEventListener('click', this.handleClickOutside);
  },

  methods: {
    handler() {
      this.toggle = !this.toggle;
    },
    submenu(item) {
      this.menu = !this.menu
      this.menuOpen = item
    },
    handleScroll() {
      const navbar = document.getElementById("topnav");
      if (
          document.body.scrollTop >= 50 ||
          document.documentElement.scrollTop >= 50
      ) {
        navbar.classList.add("nav-sticky");
      } else {
        navbar.classList.remove("nav-sticky");
      }
    },
    handleClickOutside(event) {
      if (!this.$refs.dropdownToggle.contains(event.target)) {
        this.dropdownOpen = false;
      }
    },

    scrollToTop() {
      window.scrollTo({top: 0, behavior: "smooth"});
    }
  },

}
</script>

<style lang="scss" scoped></style>